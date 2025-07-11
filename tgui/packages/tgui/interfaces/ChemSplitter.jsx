import { LabeledList, NumberInput, Section } from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ChemSplitter = (props) => {
  const { act, data } = useBackend();
  const { straight, side, max_transfer } = data;
  return (
    <Window width={220} height={105}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Straight">
              <NumberInput
                value={straight}
                unit="u"
                width="55px"
                minValue={1}
                maxValue={max_transfer}
                format={(value) => toFixed(value, 2)}
                step={0.05}
                stepPixelSize={4}
                onChange={(e, value) =>
                  act('set_amount', {
                    target: 'straight',
                    amount: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Side">
              <NumberInput
                value={side}
                unit="u"
                width="55px"
                minValue={1}
                maxValue={max_transfer}
                format={(value) => toFixed(value, 2)}
                step={0.05}
                stepPixelSize={4}
                onChange={(e, value) =>
                  act('set_amount', {
                    target: 'side',
                    amount: value,
                  })
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
