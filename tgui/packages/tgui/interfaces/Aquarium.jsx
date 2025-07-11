import { Button, Knob, LabeledControls, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Aquarium = (props) => {
  const { act, data } = useBackend();
  const {
    temperature,
    fluid_type,
    minTemperature,
    maxTemperature,
    fluidTypes,
    contents,
  } = data;
  return (
    <Window width={450} height={400} resizable>
      <Window.Content>
        <Section title="Aquarium Controls">
          <LabeledControls>
            <LabeledControls.Item label="Temperature">
              <Knob
                size={1.25}
                mb={1}
                value={temperature}
                unit="K"
                minValue={minTemperature}
                maxValue={maxTemperature}
                step={1}
                stepPixelSize={1}
                onDrag={(e, value) =>
                  act('temperature', {
                    temperature: value,
                  })
                }
              />
            </LabeledControls.Item>
            <LabeledControls.Item label="Fluid">
              {fluidTypes.map((f) => (
                <Button
                  key={f}
                  content={f}
                  selected={fluid_type === f}
                  onClick={() => act('fluid', { fluid: f })}
                />
              ))}
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
        <Section title="Contents">
          {contents.map((movable) => (
            <Button
              key={movable.ref}
              content={movable.name}
              onClick={() => act('remove', { ref: movable.ref })}
            />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
