import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Wires = (props) => {
  const { act, data } = useBackend();
  const { proper_name } = data;
  const wires = data.wires || [];
  const statuses = data.status || [];
  return (
    <Window
      width={350}
      height={150 + wires.length * 30 + (!!proper_name && 30)}
    >
      <Window.Content>
        {!!proper_name && (
          <NoticeBox textAlign="center">
            {proper_name} Wire Configuration
          </NoticeBox>
        )}
        <Section>
          <LabeledList>
            {wires.map((wire) => (
              <LabeledList.Item
                key={wire.color}
                className="candystripe"
                label={wire.color}
                labelColor={wire.color}
                color={wire.color}
                buttons={
                  <>
                    <Button
                      content={wire.cut ? 'Mend' : 'Cut'}
                      onClick={() =>
                        act('cut', {
                          wire: wire.color,
                        })
                      }
                    />
                    <Button
                      content="Pulse"
                      onClick={() =>
                        act('pulse', {
                          wire: wire.color,
                        })
                      }
                    />
                    <Button
                      content={wire.attached ? 'Detach' : 'Attach'}
                      onClick={() =>
                        act('attach', {
                          wire: wire.color,
                        })
                      }
                    />
                  </>
                }
              >
                {!!wire.wire && <i>({wire.wire})</i>}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        {!!statuses.length && (
          <Section>
            {statuses.map((status) => (
              <Box key={status}>{status}</Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
